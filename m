From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Mar 2012 08:59:11 +0000
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <alpine.DEB.2.00.1203201731550.22974@utopia.booyaka.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <201203170905.33191.arnd@arndb.de>
 <alpine.DEB.2.00.1203201731550.22974@utopia.booyaka.com>
Message-ID: <201203210859.11899.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 March 2012, Paul Walmsley wrote:
> Hello Arnd,
> 
> On Sat, 17 Mar 2012, Arnd Bergmann wrote:
> 
> > I think it's rather pointless, because the option is not going to
> > be user selectable but will get selected by the platform unless I'm
> > mistaken. The platform maintainers that care already know the state
> > of the framework.
> 
> This is where we have differing views, I think.  Clearly, Sascha, 
> Saravana, Rob, and I have at least slightly different opinions on the 
> durability of the existing API and code.  So it seems reasonable to assume 
> that others who have not followed the development of the common clock code 
> might mistake the implementation or API as being stable and well-defined.
> 
> It sounds like the primary objection is to the use of CONFIG_EXPERIMENTAL.  
> So here is a patch to simply note the status of this code in its Kconfig 
> text.

Yes, looks good to me. If there are no objections, I'll apply this one.

Thanks,

	Arnd
