From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 22 Apr 2016 10:07:09 +0100
Subject: [PATCH v5 00/11] qcom: Add support for TSENS driver
In-Reply-To: <20160420235127.GC2558@localhost.localdomain>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
 <20160420235127.GC2558@localhost.localdomain>
Message-ID: <5719E9BD.6090805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/04/16 00:51, Eduardo Valentin wrote:
> On Thu, Apr 14, 2016 at 03:01:48PM +0530, Rajendra Nayak wrote:
>> Current set of patches apply on 4.6-rc3. nvmem apis are currently
>> broken and hence need to pull in the fixes for it as proposed here [1]
>
>
> Could you please clarify this a bit?
>
> Do I understand properly that we need to wait until [1] gets merged to
> get the driver functional again after applying this series?

I think nvmem regression fixes should not stop TSENS driver from going 
to mainline.

I think you can take these patches if you are happy with them, I will 
take care of the nvmem fixes.

thanks,
srini
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
