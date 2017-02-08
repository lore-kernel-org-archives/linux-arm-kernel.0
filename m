From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 8 Feb 2017 08:09:12 -0600
Subject: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
In-Reply-To: <20170208133306.GE15459@leverpostej>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
 <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
 <20170208133306.GE15459@leverpostej>
Message-ID: <e16986de-31fa-8d34-05be-aa8a585500d4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland wrote:

>> No, only Kryo and Falkor V1 based SOCs have this problem.  Falkor V2
>> will have this fixed.  We intend to revert these fixes after Falkor
>> V1 SOCs are no longer supported.
>
> Supported by whom?

Qualcomm.

> Generally, once something's upstreamed we expect it to remain supported.

The V1 SOCs are technically pre-production, but still in wide use and it will be 
a while before they are all replaced by V2 SOCs.  It's only because of the 
"ugliness" of the erratum and its work-around that we want to git rid of it when 
we can.

Cov is better equipped to answer your other questions.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
