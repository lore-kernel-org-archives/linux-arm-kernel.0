From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Mar 2017 22:56:25 +0000
Subject: [PATCH v2] ARM: ptdump: Add domain to output
In-Reply-To: <CAGXu5j+sHPZVhw-Jt2=RPFYF-ebN_SzOd+F76A9Mxz8RY9YTVA@mail.gmail.com>
References: <20170303003033.GA92641@beast>
 <CAGXu5j+sHPZVhw-Jt2=RPFYF-ebN_SzOd+F76A9Mxz8RY9YTVA@mail.gmail.com>
Message-ID: <20170324225625.GK7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 03:54:48PM -0700, Kees Cook wrote:
> > This actually works correctly now (tested by forcing different domains on
> > portions of the Kernel Mapping. I really wanted to find a way to use the
> > existing bit structs, but I couldn't make anything work... I'm open to ideas.
> 
> Any feedback on this? Should I submit this to the ARM patch tracker?

Yes please, but with one change - the "DOMAIN_" prefix seems a little
redundant.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
