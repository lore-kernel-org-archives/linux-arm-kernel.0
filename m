From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 10 Feb 2016 09:04:27 +0100
Subject: [PATCH v2 22/28] ARM: KVM: Switch to C-based stage2 init
In-Reply-To: <20160210074247.589db14b@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-23-git-send-email-marc.zyngier@arm.com>
 <20160209184513.GX5171@cbox> <20160210074247.589db14b@arm.com>
Message-ID: <20160210080427.GG5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 07:42:47AM +0000, Marc Zyngier wrote:
> On Tue, 9 Feb 2016 19:45:13 +0100
> Christoffer Dall <christoffer.dall@linaro.org> wrote:
> 
> > Mising (sarcastic) commit message?
> 
> Ah! I'll try to think of something along the lines of:
> 
> "Let's now retire the code that bravely served us for three
> years, and enjoy a brand new set of bugs. At least, we can blame the
> compiler this time."
> 
You are the master of those ;)

-Christoffer
