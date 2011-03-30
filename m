From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 30 Mar 2011 10:00:15 +0800
Subject: [PATCH 1/1] ARM: imx: add gpu device
In-Reply-To: <20110329183709.GB18135@n2100.arm.linux.org.uk>
References: <1301401725-17555-1-git-send-email-richard.zhao@freescale.com>
	<20110329183709.GB18135@n2100.arm.linux.org.uk>
Message-ID: <20110330020013.GA19132@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 07:37:09PM +0100, Russell King - ARM Linux wrote:
> On Tue, Mar 29, 2011 at 08:28:45PM +0800, Richard Zhao wrote:
> > +extern const struct imx_mxc_gpu_data imx35_gpu_data __initconst;
> 
> We don't tend to mark the sections of extern data or functions.
There' many __initconst in files like that. We have to remove that all?
I'll send out v2 patch. I forgot to change copyright of the new file.

Thanks
Richard
> 
