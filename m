From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Jan 2012 16:22:26 +0530
Subject: [PATCH 5/8] dmaengine/dw_dmac: Use platform_get_drvdata instead
 of accessing dev directly
In-Reply-To: <4F14004F.2010906@ru.mvista.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <51d3263224d48c1d68de1449af28fb1570900254.1326707233.git.viresh.kumar@st.com>
 <4F14004F.2010906@ru.mvista.com>
Message-ID: <4F14016A.4090209@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/16/2012 4:17 PM, Sergei Shtylyov wrote:
>> > Use already defined function platform_get_drvdata() instead of accessing
>> > pdev->dev.data.
>     pdev->dev.platform_data.
> 

Oops!! Will fix comment once i get comments over other patches too.

-- 
viresh
