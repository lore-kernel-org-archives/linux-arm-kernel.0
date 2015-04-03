From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 11:25:28 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.1 #3
In-Reply-To: <20150331003152.GF32500@ld-irv-0074>
References: <1427235082-27415-1-git-send-email-f.fainelli@gmail.com>
 <20150331003152.GF32500@ld-irv-0074>
Message-ID: <20150403182528.GP23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 05:31:52PM -0700, Brian Norris wrote:
> On Tue, Mar 24, 2015 at 03:11:22PM -0700, Florian Fainelli wrote:
> > The following changes since commit cd590b50a9367b52520f6866b27f72317bb1a07e:
> > 
> >   ARM: dts: enable PCIe support for Cygnus (2015-03-13 09:20:47 -0700)
> > 
> > are available in the git repository at:
> > 
> >   http://github.com/broadcom/stblinux tags/arm-soc/for-4.1/devicetree-part-3
> > 
> > for you to fetch changes up to 0c02acec74b655fe44b698d293f6f2a9600c4a8b:
> > 
> >   ARM: dts: brcmstb: add IRQ0 controller (2015-03-19 09:34:14 -0700)
> > 
> > ----------------------------------------------------------------
> > This pull request contains changes to the BCM7445 reference DTS files from
> > Brian:
> > 
> > - making a clock-frequency property decimal instead of hexadecimal
> > 
> > - adding the irq0 interrupt controller node to make the reference DTS bootable
> >   again

Applied the equivalent patch since yours lacked signed-off.   Can't really
squash it into a merge commit.


-Olof
