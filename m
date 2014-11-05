From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 6 Nov 2014 00:45:56 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <20141105220359.GA32052@amd>
References: <20141104205117.GA17606@amd> <201411052137.31452@pali>
 <20141105203918.GA29199@amd> <201411052206.05379@pali>
 <20141105220359.GA32052@amd>
Message-ID: <20141105234555.GA7097@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 05, 2014 at 11:03:59PM +0100, Pavel Machek wrote:
> > Maybe you need to enable modem?
> > 
> > This is n900 init sequence from script: nokia-n900-configs.sh
> 
> From the dts, it looks like this should somehow work without this.

Right :) The n900-modem driver will take care of this if the "pm"
parameter is set to 1 (which should be the default).

> I can try but.. is it safe? I'm using DT-based config, and interrupt
> numbers definitely changed. If GPIO numbers changed, it will not be
> funny.

Can you provide the output from dmesg?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/fb830555/attachment.sig>
