From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 5 Oct 2017 12:02:27 +0100
Subject: [PATCH 1/3] firmware: arm_scpi: improve struct dvfs_info to make
 code better readable
In-Reply-To: <16d1cd8c-e124-cc94-ca29-d7cb04ff26d9@gmail.com>
References: <16d1cd8c-e124-cc94-ca29-d7cb04ff26d9@gmail.com>
Message-ID: <9df74d4d-8412-ac4a-50c2-c7b256a9ee78@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/10/17 19:56, Heiner Kallweit wrote:
> Making the header subfields members of struct dvfs_info allows to make
> the code better readable and avoids some macro magic.
> 
> In addition remove a useless statement using info->latency.
> 

All 3 looks trivial and applied now. Thanks for the cleanup.

I found couple of other trivial things that can be cleaned. I will CC
you on them, it would be good if you can review and/or test.

I need to send PR by end of this week or early next week.

-- 
Regards,
Sudeep
