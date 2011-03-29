From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Mar 2011 19:37:09 +0100
Subject: [PATCH 1/1] ARM: imx: add gpu device
In-Reply-To: <1301401725-17555-1-git-send-email-richard.zhao@freescale.com>
References: <1301401725-17555-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110329183709.GB18135@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 08:28:45PM +0800, Richard Zhao wrote:
> +extern const struct imx_mxc_gpu_data imx35_gpu_data __initconst;

We don't tend to mark the sections of extern data or functions.
