From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 14 Feb 2017 18:48:20 -0500
Subject: [PATCH 2/2] tty: pl011: Work around QDF2400 E44 for earlycon
In-Reply-To: <0262b9d0-1fd1-ff56-a7c5-b9ab9dcea9a8@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <20170208005736.18724-2-cov@codeaurora.org>
 <35007ccc-678d-0e2a-109b-4b5321c4fbff@codeaurora.org>
 <0262b9d0-1fd1-ff56-a7c5-b9ab9dcea9a8@codeaurora.org>
Message-ID: <cb5e44c7-3be2-3b10-d133-aaea72c2a485@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2017 11:31 PM, Shanker Donthineni wrote:
> Hi Cov,
> 
> The same PL011 driver will be used in virtutal machine, make sure
> your changes have no side effects in VM.

Fundamentally, this is the same workaround as has been tested in the qserver
downstream kernel for over a year.

Cheers,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
