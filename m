From: keescook@chromium.org (Kees Cook)
Date: Fri, 8 Sep 2017 08:44:22 -0700
Subject: [PATCH v6 10/11] mm: add a user_virt_to_phys symbol
In-Reply-To: <20170908075519.GD4957@infradead.org>
References: <20170907173609.22696-1-tycho@docker.com>
 <20170907173609.22696-11-tycho@docker.com>
 <20170908075519.GD4957@infradead.org>
Message-ID: <CAGXu5jL8wRg2307wKkGf9ASZHTtYZMwPzn10100-Mfmx9p2=Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 8, 2017 at 12:55 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Sep 07, 2017 at 11:36:08AM -0600, Tycho Andersen wrote:
>> We need someting like this for testing XPFO. Since it's architecture
>> specific, putting it in the test code is slightly awkward, so let's make it
>> an arch-specific symbol and export it for use in LKDTM.
>
> We really should not add an export for this.
>
> I think you'll want to just open code it in your test module.

Isn't that going to be fragile? Why not an export?

-Kees

-- 
Kees Cook
Pixel Security
