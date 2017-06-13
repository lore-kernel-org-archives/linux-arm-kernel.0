From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 13 Jun 2017 12:03:58 +0200
Subject: [PATCH 15/18] staging: fsl-dpaa2/eth: Reorder priv fields
In-Reply-To: <20170606150041.10955-16-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
 <20170606150041.10955-16-ruxandra.radulescu@nxp.com>
Message-ID: <20170613100358.GA11444@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 10:00:38AM -0500, Ioana Radulescu wrote:
> Reorder fields in the device's private structure such that
> the ones most used on the hotpath are at the beginning of
> the structure.
> 
> This brings a small performance improvement due to better
> cache usage.

Really?  What kind of performance improvement?  Always be specific.

Please fix up and resend.

thanks,

greg k-h
