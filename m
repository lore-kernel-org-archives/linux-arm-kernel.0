From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 05 Nov 2015 12:21:48 +0530
Subject: [PATCH v4 0/8] qcom: Add support for TSENS driver
In-Reply-To: <20151102201345.GA4238@localhost.localdomain>
References: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
 <20151102201345.GA4238@localhost.localdomain>
Message-ID: <563AFC84.3070807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

On 11/03/2015 01:43 AM, Eduardo Valentin wrote:
> Rajendra,
> 
> On Fri, Oct 09, 2015 at 03:11:02PM +0530, Rajendra Nayak wrote:
>> Patches 1/8 to 4/8 will need to go via the thermal tree/Eduardo.
>> Patches 5/8 to 8/8 will need to go via qcom-msm tree/Andy.
>>
>> Eduardo, can you please take a look at the patches and let me
>> know if you see any issues.
>>
> 
> Thanks for your taking this over. I am assuming this superseeds the
> work by Narendran.

Yes, thats correct. I took Naren's work to add support for msm8960
family and created a single driver to work across msm8960 and
msm8974/8916/8084 SoCs.

regards,
Rajendra
