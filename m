From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 15 Apr 2014 20:01:48 +0200
Subject: [PATCH v2 7/7] ARM: dts: update macros in clock bindings for
 exynos5420
In-Reply-To: <1395918470-16374-8-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
 <1395918470-16374-8-git-send-email-shaik.ameer@samsung.com>
Message-ID: <534D740C.2060904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

On 27.03.2014 12:07, Shaik Ameer Basha wrote:
> From: Rahul Sharma <rahul.sharma@samsung.com>
>
> This patch updates the macros as per the latest changes and
> replaces magic numbers with macros defined in DT header for
> exynos5420.
>

Contents of dts files are not "bindings", they are just device tree 
sources/data, defined according to some bindings. Bindings are defined 
sets of nodes and properties and their formats, as you can see in 
Documentation/devicetree/bindings/, where documentation of supported 
bindings is available.

So this patch doesn't update clock bindings, but rather device nodes. 
Following would be more appropriate: "ARM: dts: update clock IDs in 
device tree of Exynos5420".

However, as mentioned in comments to previous patches, most (if not all) 
of the changes below could be probably dropped.

Best regards,
Tomasz
