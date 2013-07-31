From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 31 Jul 2013 18:29:19 +0200
Subject: [Ksummit-2013-discuss] Defining schemas for Device Tree
In-Reply-To: <2300415.ZNNddtVGav@thinkpad>
References: <1706112.Xn49tiCSKF@thinkpad> <20130731113401.GM9858@sirena.org.uk>
 <CAKON4OyQUcqw1RFcWj3uy0i2i+3UBB8fG1rPw6tcrMGDZ40y6g@mail.gmail.com>
 <2300415.ZNNddtVGav@thinkpad>
Message-ID: <20130731182919.1168b88e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Tomasz Figa,

On Wed, 31 Jul 2013 14:21:49 +0200, Tomasz Figa wrote:

> u-boot still does not have generic driver model or at least did not have when 
> I last checked it not so long ago, so it seems like there is still long way to 
> go for using FDT as source of information about hardware in u-boot.
> 
> barebox [1], aka u-boot-v2, might be closer to this approach (it might be 
> already using it, but this needs to be checked) as it already has generic 
> driver model and support for DT.

There are already some platforms in Barebox that are using the Device
Tree. For example, the basic Marvell platforms support in Barebox now
uses the Device Tree.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
