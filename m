From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Jul 2013 12:39:12 +0200
Subject: [PATCH 08/10] ARM: sunxi: dt: Add PIO controller to A31 DTSI
In-Reply-To: <1374618312-19001-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130726123912.3dd65bb7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Wed, 24 Jul 2013 00:25:10 +0200, Maxime Ripard wrote:
> The A31 has a different set of pins than the one found on the A10 and
> A13, so we will need a different compatible string, even though the IP
> is the same.

Why "we will" ? Isn't this patch presently using a different compatible
string?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
