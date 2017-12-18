From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 18 Dec 2017 11:47:04 +0000
Subject: [RFC PATCH 5/5] ARM: NOMMU: Support PMSAv8 MPU
In-Reply-To: <20171214050111.GA5097@afzalpc>
References: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
 <1513184527-44120-6-git-send-email-vladimir.murzin@arm.com>
 <20171214050111.GA5097@afzalpc>
Message-ID: <7c64f605-462b-728c-36d7-e8380c3f16db@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/12/17 05:01, afzal mohammed wrote:
> Hi,
> 
> On Wed, Dec 13, 2017 at 05:02:07PM +0000, Vladimir Murzin wrote:
> 
>> ARMv8R/M architecture defines new memory protection scheme - PMSAv8
> 
> Is there a public ARMv8-R architecture reference manual available ?,
> seems only ARMv8-A and ARMv8-M ARM's are publically available.

Not sure why it is not there yet, but with respect to the patch set
you might get PMSA-v8 related information from Cortex-R52 TRM [1].

[1] https://developer.arm.com/docs/100026/latest/preface

Vladimir

> 
> afzal
> 
