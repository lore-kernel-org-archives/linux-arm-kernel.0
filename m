From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jul 2014 16:50:12 +0100
Subject: [PATCHv4 2/5] lib/genalloc.c: Add genpool range check function
In-Reply-To: <53CD6F28.3080203@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-3-git-send-email-lauraa@codeaurora.org>
 <CAOesGMiKBNDmJhiY-yK0uZmG-MnK82=ffNGxqasLKozqgpQQpw@mail.gmail.com>
 <53CD6F28.3080203@codeaurora.org>
Message-ID: <20140722155012.GK2219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 08:51:04PM +0100, Laura Abbott wrote:
> On 7/9/2014 3:33 PM, Olof Johansson wrote:
> > On Wed, Jul 2, 2014 at 11:03 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
> >>
> >> After allocating an address from a particular genpool,
> >> there is no good way to verify if that address actually
> >> belongs to a genpool. Introduce addr_in_gen_pool which
> >> will return if an address plus size falls completely
> >> within the genpool range.
> >>
> >> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> > 
> > Reviewed-by: Olof Johansson <olof@lixom.net>
> > 
> > What's the merge path for this code? Part of the arm64 code that needs
> > it, I presume?
> 
> My plan was to have the entire series go through the arm64 tree unless
> someone has a better idea.

It's fine by me. But since it touches core arch/arm code, I would like
to see an Ack from Russell.

-- 
Catalin
