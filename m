From: joe@perches.com (Joe Perches)
Date: Mon, 17 Mar 2014 20:19:16 -0700
Subject: [PATCH 00/12] scsi/NCR5380: fix debugging macros and #include
 structure
In-Reply-To: <20140318002822.372705594@telegraphics.com.au>
References: <20140318002822.372705594@telegraphics.com.au>
Message-ID: <1395112756.20860.1.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-18 at 11:28 +1100, Finn Thain wrote:
> This patch series addresses several issues with NCR5380 drivers:
[]
> 3. Broken debugging code.

My preference would be to change dprintk to scsi_dbg

Seems sensible otherwise.
