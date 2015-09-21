From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Sep 2015 10:09:52 +0200
Subject: [PATCH v6 1/5] pwm: add the Berlin pwm controller driver
In-Reply-To: <55FEF75C.4090802@gmail.com>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
 <1442484788-15482-2-git-send-email-antoine.tenart@free-electrons.com>
 <55FEF75C.4090802@gmail.com>
Message-ID: <20150921080952.GC19865@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 20, 2015 at 08:13:48PM +0200, Sebastian Hesselbarth wrote:
> On 17.09.2015 12:13, Antoine Tenart wrote:
> >Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> >controller has 4 channels.
> >
> >Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> >Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> Thierry,
> 
> if you are also fine with the driver, please let me know if you want
> me to take the driver through berlin-tree or if you are taking it.
> 
> I am taking the binding docs and dts changes anyway.

Sorry but no. The binding documentation needs to go into the same tree
as the driver because they need to be kept in sync. We can't have DT
binding documentation go into platform trees if the driver implementing
the binding hasn't been merged.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150921/a3a64cbc/attachment-0001.sig>
