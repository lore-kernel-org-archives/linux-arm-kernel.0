From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Mar 2017 20:00:36 +0000
Subject: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
In-Reply-To: <4ccb4d92-3830-3980-38c3-7085a3d97734@codeaurora.org>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
 <31da6db5-be22-9e84-5e76-67c519bc0b34@codeaurora.org>
 <CAKv+Gu8Uw-X3AR6aQYevPdRfcgPNnqL4O3sRoKxsZAiW29sbqg@mail.gmail.com>
 <704b8b8c-e607-29b3-e101-bbecd90073bb@codeaurora.org>
 <CAKv+Gu-3wAXLyogLxg3N=6vf6Ryz2cLXw01tZUR_E48ddVU22A@mail.gmail.com>
 <4ccb4d92-3830-3980-38c3-7085a3d97734@codeaurora.org>
Message-ID: <CAKv+Gu9wORrhcYGLFdSubMrJiKwKzFBJkzS79Odc8sJRf6bJhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 March 2017 at 19:57, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/22/2017 3:52 PM, Ard Biesheuvel wrote:
[..]
>> If you have working EFIFB on your platform, it works by accident. This
>> patch is needed to ensure that the BAR associated with the EFI
>> framebuffer is left untouched.
>>
>
> I never claimed that. I was just double checking your assumptions.
> I really don't like ARM64 specific PCI code in general. PCI doesn't care
> about CPU type. I hope to see this patch become part of common code.
>

Good! Thanks
