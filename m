From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 5 May 2017 10:20:20 +0800
Subject: [PATCH] arch: arm64: Define big endian of IFC for LS1043a/LS1046a
In-Reply-To: <1493889032-20857-1-git-send-email-prabhakar.kushwaha@nxp.com>
References: <1493889032-20857-1-git-send-email-prabhakar.kushwaha@nxp.com>
Message-ID: <20170505022017.GU18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 02:40:31PM +0530, Prabhakar Kushwaha wrote:
> Integrated flash controller present in LS1043A and LS1046A is big endian.
> 
> So add big endian property in the devive tree.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>

The subject prefix should be 'arm64: dts: ...'.  I fixed it up and
applied the patch.

Shawn
