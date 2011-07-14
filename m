From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jul 2011 07:42:03 +0100
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <201107132251.48606.arnd@arndb.de>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<4E1DCA83.7010204@codeaurora.org> <20110713203226.GA23055@suse.de>
	<201107132251.48606.arnd@arndb.de>
Message-ID: <4E1E8FBB.1040002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It seems the final outcome was to have a data structure of function
> pointers to get the attribute contents, which is less nice but still
> acceptable IMHO.

I did think this was a little neater than passing strings all over the
place. I'm pleased you think this patch is now acceptable. Would you
mind re-enforcing your approval with a Signed-off-by please?

I will endeavor to look at the other patch and attempt to reorganise the
Platform Drivers in sysfs sometime soon after this one has been accepted.

Kind regards,
Lee
