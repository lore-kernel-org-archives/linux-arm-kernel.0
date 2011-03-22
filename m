From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 22 Mar 2011 17:55:13 +0530
Subject: [PATCH v17 10/13] davinci: dm644x: change vpfe capture
	structure variables for consistency
In-Reply-To: <1300197552-4780-1-git-send-email-manjunath.hadli@ti.com>
References: <1300197552-4780-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C47D7B8@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2011 at 19:29:12, Hadli, Manjunath wrote:
> change the vpfe capture related configuration structure variables from
> <config> to dm644xevm_<config> to make it consistent with the rest of
> the file.

This description is not fully accurate. You also have changes
where you add SoC prefix to variable names. I guess you can just
say "Add SoC and board prefixes to variable names so that.."

Thanks,
Sekhar
