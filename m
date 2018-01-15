From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Jan 2018 12:36:58 +0000
Subject: [PATCH v6 03/12] cacheinfo: rename of_node to fw_unique
In-Reply-To: <20180113005920.28658-4-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-4-jeremy.linton@arm.com>
Message-ID: <20180115123658.GC5473@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 06:59:11PM -0600, Jeremy Linton wrote:
> Rename and change the type of of_node to indicate
> it is a generic pointer which is generally only used
> for comparison purposes. In a later patch we will apply
> an ACPI/PPTT "token" pointer in fw_unique so that
> the code which builds the shared cpu masks can be reused.
> 

[Nit] as used in the commit log, I prefer fw_token over fw_unique.
But I am fine if you/others prefer fw_unique.

Otherwise,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
