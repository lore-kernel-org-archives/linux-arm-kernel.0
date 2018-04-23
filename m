From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Apr 2018 10:30:38 -0600
Subject: [PATCH v2] coresight: Moving framework and drivers to SPDX
 identifier
In-Reply-To: <20180423113828.GA8720@kroah.com>
References: <1523981817-16176-1-git-send-email-mathieu.poirier@linaro.org>
 <20180423113828.GA8720@kroah.com>
Message-ID: <CANLsYkyyRdyFOANZH8oprxuF9n9rFXj_mXasyeOuCp-sb5ZOsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2018 at 05:38, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 17, 2018 at 10:16:57AM -0600, Mathieu Poirier wrote:
>> Moving all kernel side CoreSight framework and drivers to SPDX identifier.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> ---
>> Change for V2:
>> * Added drivers/hwtracing/stm/ftrace.c as pointed out by Alex.
>
> This doesn't apply to 4.17-rc2 :(

My goal was to "socialise" the patch before including it in my tree
where there are other dependencies.  I will send you the whole tally
around rc3 or rc4, as usual.

Thanks,
Mathieu

>
> thanks,
>
> greg k-h
