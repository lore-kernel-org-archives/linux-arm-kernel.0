From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 21 Jun 2013 14:50:55 +0100
Subject: [PATCH v3 01/10] serial:st-asc: Add ST ASC driver.
In-Reply-To: <201306202101.11261.arnd@arndb.de>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
 <1371737103-8871-1-git-send-email-srinivas.kandagatla@st.com>
 <201306202101.11261.arnd@arndb.de>
Message-ID: <51C45A3F.7000009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,
If its not too late can this patch be considered for 3.11 via tty tree?
Arnd preferred to take the SOC patches in this series via arm-soc tree.
Also, there is no build dependency for this patch.

Thanks,
srini

On 20/06/13 20:01, Arnd Bergmann wrote:
> On Thursday 20 June 2013, Srinivas KANDAGATLA wrote:
>> This patch adds support to ASC (asynchronous serial controller)
>> driver, which is basically a standard serial driver. This IP is common
>> across all the ST parts for settop box platforms.
>>
>> ASC is embedded in ST COMMS IP block. It supports Rx & Tx functionality.
>> It support all industry standard baud rates.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> CC: Stephen Gallimore <stephen.gallimore@st.com>
>> CC: Stuart Menefy <stuart.menefy@st.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>>From my point of view the series is ready for merging in 3.11,
> I only had a few final comments. I would prefer the first three
> patches to go through the respective serial/clocksource/pinctrl
> trees, since there are no direct build dependencies to the
> platform parts.
> 
> If there is a reason to take those through arm-soc, I would
> insist on getting Acked-by's from the subsystem maintainers.
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
