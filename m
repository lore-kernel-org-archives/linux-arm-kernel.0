From: mickael.guene@st.com (Mickael GUENE)
Date: Fri, 25 Aug 2017 14:27:46 +0000
Subject: [PATCH v2 0/8] ELF-FDPIC support for ARM
In-Reply-To: <20170817083716.GN20805@n2100.armlinux.org.uk>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
 <20170817083716.GN20805@n2100.armlinux.org.uk>
Message-ID: <e181fb7b-3ef5-9f22-0aa5-c25e280a3fd8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Mickael GUENE <mickael.guene@st.com> for the whole patch series.

Thanks to you Nicolas for your upstreaming efforts.

Regards
Mickael

On 08/17/2017 10:37 AM, Russell King - ARM Linux wrote:
> On Thu, Aug 17, 2017 at 03:23:39AM -0400, Nicolas Pitre wrote:
>> This series provides the needed changes to suport the ELF_FDPIC binary
>> format on ARM. Both MMU and non-MMU systems are supported. This format
>> has many advantages over the BFLT format used on MMU-less systems, such
>> as being real ELF that can be parsed by standard tools, can support
>> shared dynamic libs, etc.
> 
> I don't see anything issues from the core arch point of view with this,
> most of it looks straight forward, and the impact on existing users
> should be low.  However, it would be nice to get some acks (if possible)
> for the non-arch stuff and some tested-by's on this.
> 
