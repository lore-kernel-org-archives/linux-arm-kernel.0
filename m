From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 1 Nov 2009 12:34:34 +0000
Subject: [PATCH] S3C: ide: Add Samsung S3C IDE controller driver
In-Reply-To: <1257052029-8406-1-git-send-email-thomas.ab@samsung.com>
References: <1257052029-8406-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20091101123434.245b4d84@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  1 Nov 2009 14:07:09 +0900
Thomas Abraham <thomas.ab@samsung.com> wrote:

> This patch adds Samsung S3C IDE controller driver. This driver supports
> PIO and UDMA modes of data transfer.

drivers/ide is old code in maintenance mode only. New drivers should be
using libata.
