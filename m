From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 4 May 2012 09:22:15 +0530
Subject: [PATCH 1/2] SPEAr: Add SMI NOR partition info in dts files
In-Reply-To: <20120504024123.GB26478@walimis-desktop>
References: <bd96eb0df2e50de1293a8df60d30ceea920fe2b0.1336041348.git.viresh.kumar@st.com>
 <20120504024123.GB26478@walimis-desktop>
Message-ID: <4FA3526F.9040205@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/4/2012 8:11 AM, walimis wrote:
>> >+				partition at 310000 {
>> >+					label = "rootfs";
>> >+					reg = <0x310000 0x230000>;

> I have one question: we know smi nor flash has 8M Bytes, why we leave 
> 0x2c0000 Bytes unused?

Correct. Either i make rootfs partition size 4f0000 or is there someway to say: 
everything else belongs to rootfs? Will leaving size field blank for rootfs do this?

-- 
viresh
