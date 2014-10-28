From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Oct 2014 14:21:45 +0000
Subject: [PATCH v2 1/5] ARM: introduce a CONFIG_ARCH_MULTIPLATFORM_STRICT
 Kconfig option
In-Reply-To: <71099905.SGyci24BjF@wuerfel>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <1414503095-25986-2-git-send-email-kaixu.xia@linaro.org>
 <71099905.SGyci24BjF@wuerfel>
Message-ID: <20141028142145.GG27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:18:48PM +0100, Arnd Bergmann wrote:
> On Tuesday 28 October 2014 21:31:31 Xia Kaixu wrote:
> >  endmenu
> >  
> > +config ARCH_MULTIPLATFORM_STRICT
> > +        bool "Only allow options that do not break other platforms"
> > +        depends on ARCH_MULTIPLATFORM
> > +        default y
> > +       help
> > +          There are several configuration options that can only work
> > 
> 
> Something seems to be wrong with the whitespace here. Please use tab
> characters for indentation like we do elsewhere in the file.
> 
> Otherwise looks good, I think this is a good step in the right direction.

I totally disagree.  I've raised individual objections on all uses of
this new symbol in separate emails.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
