From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Feb 2013 17:41:48 -0800
Subject: [PATCH v4 2/3] ARM: mach-shmobile: r8a7779: add SATA support
In-Reply-To: <201302272339.15402.sergei.shtylyov@cogentembedded.com>
References: <201302272339.15402.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130301014148.GB9232@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 11:39:14PM +0300, Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add SATA clock for r8a7779 SoC (for both device tree and usual cases). 
> Register SATA controller as a "late" platform device on r8a7779 SoC.

Hi,

If you have the a binding in the device tree (which you do through patch 1/3),
then there's no reason to have a platform device for it.


-Olof
