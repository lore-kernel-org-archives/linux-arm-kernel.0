From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 9 Feb 2016 16:32:17 +0530
Subject: [PATCH v2] ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
In-Reply-To: <alpine.DEB.2.02.1602090917040.2906@utopia.booyaka.com>
References: <1455008743-21660-1-git-send-email-kishon@ti.com>
 <alpine.DEB.2.02.1602090917040.2906@utopia.booyaka.com>
Message-ID: <56B9C739.5050103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 09 February 2016 02:48 PM, Paul Walmsley wrote:
> On Tue, 9 Feb 2016, Kishon Vijay Abraham I wrote:
> 
>> OCP2SCP doesn't support smart idle wakeup according to
>> Table 26-22. OCP2SCP_SYSCONFIG in AM572x TRM [1] and
>> Table 26-22. OCP2SCP_SYSCONFIG in AM571x TRM [2].
>> Remove SIDLE_SMART_WKUP from the list of supported SIDLE modes
>> in hwmod data.
>>
>> [1] -> http://www.ti.com/lit/ug/spruhz6e/spruhz6e.pdf
>> [2] -> http://www.ti.com/lit/ug/spruhz7a/spruhz7a.pdf
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks, queued for v4.6.  If you'd like it queued as a fix, please resend 
> with a description of the regression that it fixes.

Found this during review and as such it didn't cause any regressions. So I
think it's okay to be queued for 4.6

Thanks
Kishon
