From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 6 Mar 2018 16:45:03 +0000
Subject: [PATCH v7 03/13] cacheinfo: rename of_node to fw_token
In-Reply-To: <20180228220619.6992-4-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-4-jeremy.linton@arm.com>
Message-ID: <4864c763-0d11-9e09-ff02-87e94b410da6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/02/18 22:06, Jeremy Linton wrote:
> Rename and change the type of of_node to indicate
> it is a generic pointer which is generally only used
> for comparison purposes. In a later patch we will put
> an ACPI/PPTT token pointer in fw_token so that
> the code which builds the shared cpu masks can be reused.
> 
Thanks for renaming :)

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
