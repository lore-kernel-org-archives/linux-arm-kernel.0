From: keescook@chromium.org (Kees Cook)
Date: Mon, 24 Oct 2016 11:18:35 -0700
Subject: [PATCH 00/10] arm64: move thread_info off of the task stack
In-Reply-To: <20161024181548.GA8275@leverpostej>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
 <10401f46-cabc-23ec-a448-c377dbce7911@redhat.com>
 <20161024174840.GR15620@leverpostej>
 <fb8c8a44-36c8-9bbb-5cbb-9b42fd815d8d@redhat.com>
 <20161024180941.GT15620@leverpostej>
 <20161024181548.GA8275@leverpostej>
Message-ID: <CAGXu5jKXoo5KWqq0dsWRFvW0Y3dXXs+-ab=ymVUnzcmovUsOkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 11:15 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Oct 24, 2016 at 07:09:42PM +0100, Mark Rutland wrote:
>> It's really crazy how broken a kernel can be yet still "work"; clearly
>> we better tests are needed. :/
>
> Clearly we better grammar need too. :(

Out of curiosity, what workflow would have tripped over the entry.S bug?

-Kees

-- 
Kees Cook
Nexus Security
