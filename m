From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 3 Jun 2013 12:01:36 -0400 (EDT)
Subject: [PATCH V3 2/2] USB: OHCI: add a name for the platform-private
 field
In-Reply-To: <1370272569-463-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306031201140.1304-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Jun 2013, Manjunath Goudar wrote:

> This patch adds an ohci->priv field for private use by OHCI
> platform drivers.
> 
> Until now none of the platform drivers has used this private space,
> but that's about to change in the next patch of this series.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
