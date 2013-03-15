From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 18:16:14 +0000
Subject: [PATCH 1/2] ARM: vexpress: Enable regulator framework when
 MMCI is in use
In-Reply-To: <1363365540-23001-2-git-send-email-pawel.moll@arm.com>
References: <1363365540-23001-1-git-send-email-pawel.moll@arm.com>
 <1363365540-23001-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20130315181614.GY4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 04:38:59PM +0000, Pawel Moll wrote:
> As the MMCI driver obtains some of the platform data from
> a regulator (described by the device tree), the framework must
> be present - otherwise device's initialisation will fail.

More description is required here.  How does it fail.  Please describe
the problem fully.

MMCI should work without regulator support.
