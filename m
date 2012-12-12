From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Dec 2012 22:20:21 +0000
Subject: [PATCH v4 3/7] watchdog: sp805_wdt depends on ARM
In-Reply-To: <20121212212124.GB31853@spo001.leaseweb.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <1355146956-6009-4-git-send-email-ciminaghi@gnudd.com>
 <20121212212124.GB31853@spo001.leaseweb.com>
Message-ID: <CACxGe6vaAAj_HNc5hzFAk-xL+PA=mj9S3DgL1yArjuQ5-e8iSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 9:21 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Davide
>
>> From: Alessandro Rubini <rubini@gnudd.com>
>>
>> The SP805 driver is only used by the Spear machines, and uses
>> writel_relaxed, which is not available on all architectures.
>>
>> The dependency from CONFIG_ARM avoids compilation problems under
>> randomconfig when CONFIG_ARM_AMBA is enabled for x86 builds.
>>
>> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
>> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
>> Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>
>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Point of order. Adding Signed-off-by is only appropriate if you have
actually "handled" a patch (ie. either applied it to your own git tree
or you are reposting it). If you're merely stating that you're okay
with the patch then "Acked-by" is what you should use.

Signed-off-by is more properly about asserting that you received the
patch under licensing terms compatible with the current. See
Developer's Certificate of Origin in Documentation/SubmittingPatches
for details.

g.
