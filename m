From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 17:11:59 +0000
Subject: [PATCH v6 9/9] ARM: vexpress: Add Device Tree for V2P-CA15
 core tile (TC1 variant)
In-Reply-To: <4F184C48.2050505@citrix.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-10-git-send-email-pawel.moll@arm.com>
 <4F0C495C.4000103@citrix.com>
 <1326979652.32197.66.camel@hornet.cambridge.arm.com>
 <4F181BD9.20401@gmail.com>
 <1326980594.32197.67.camel@hornet.cambridge.arm.com>
 <4F182248.7070209@gmail.com>
 <1326984672.32197.68.camel@hornet.cambridge.arm.com>
 <4F184C48.2050505@citrix.com>
Message-ID: <20120119171159.GA10404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 05:00:56PM +0000, David Vrabel wrote:
> I don't expect any real production vexpress system to use this config
> options

I do - _if_ I decide to try DT on my Versatile Express.  That'll be
with the existing boot setup, which will be ATAG based.
