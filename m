From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 11 Apr 2014 13:50:33 +0900
Subject: [PATCH 15/27] ARM: dts: exynos3250: Add uart dt node to support
 seiral ports
In-Reply-To: <CAK9yfHxdeJarGCYgLADpxYS3BtxLt6hg0NJBrdYqrcKctFqU1g@mail.gmail.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
 <1397124377-16969-7-git-send-email-cw00.choi@samsung.com>
 <CAK9yfHxdeJarGCYgLADpxYS3BtxLt6hg0NJBrdYqrcKctFqU1g@mail.gmail.com>
Message-ID: <53477499.3030901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/11/2014 01:03 PM, Sachin Kamat wrote:
> On 10 April 2014 15:36, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch add UART dt node for Exynos3250. Exynos3250 uses same UART IP
>> of Exynos4 SoC and has only two independent channels.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> [Fix incorrect clock id by Tomasz Figa]
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
> 
> typo in patch subject: s/seiral/serial
> 

I'll fix it. Thanks.

Best Regards,
Chanwoo Choi
