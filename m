From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 4 Jan 2017 15:56:15 +0800
Subject: [PATCH v6 01/14] ACPI: ARM64: IORT: minor cleanup for
 iort_match_node_callback()
In-Reply-To: <20170103140839.GC7478@red-moon>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-2-git-send-email-hanjun.guo@linaro.org>
 <20170103140839.GC7478@red-moon>
Message-ID: <49365234-2f2f-1607-e520-b98b61e1b5e9@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2017/1/3 22:08, Lorenzo Pieralisi wrote:
> On Mon, Jan 02, 2017 at 09:31:32PM +0800, Hanjun Guo wrote:
>> Cleanup iort_match_node_callback() a little bit to reduce
>> some lines of code, aslo fix the indentation in iort_scan_node().
>
> s/aslo/also
>
> "Also" in a commit log is a sign a patch should be split and that's what
> you should do even though I know it is tempting to merge all trivial
> changes into one single patch.
>
> Make it two patches please.

Will do, thanks!

Do you have more comments regarding this patch set? I will
incorporate all the comments and send out a new version.

Thanks
Hanjun
