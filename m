From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 17 Oct 2018 15:32:23 -0700
Subject: [PATCH 1/2] serial: set suppress_bind_attrs flag only if builtin
In-Reply-To: <e0763032-3ae6-b352-e586-ad131ce689ca@codeaurora.org>
References: <20181017140311.28679-1-anders.roxell@linaro.org>
 <20181017150546.0d451252950214bec74a6fc8@linux-foundation.org>
 <e0763032-3ae6-b352-e586-ad131ce689ca@codeaurora.org>
Message-ID: <20181017153223.6c4e5156895dad7973f7d059@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018 16:21:08 -0600 Jeffrey Hugo <jhugo@codeaurora.org> wrote:

> On 10/17/2018 4:05 PM, Andrew Morton wrote:
> > On Wed, 17 Oct 2018 16:03:10 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:
> > 
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > 
> > This should have Arnd's Signed-off-by: as well.
> 
> I'm just interested to know, why?

So that Arnd certifies that

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

and all the other stuff in Documentation/process/submitting-patches.rst
section 11!

Also, because section 12 says so :)  And that final sentence is, I
believe, appropriate.
