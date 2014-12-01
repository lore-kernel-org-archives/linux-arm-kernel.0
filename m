From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 1 Dec 2014 14:47:41 -0600
Subject: [RESEND PATCHv5 5/5] arm: dts: Add Altera L2 Cache and OCRAM EDAC
In-Reply-To: <546BB27A.20405@opensource.altera.com>
References: <1415751263-1830-1-git-send-email-tthayer@opensource.altera.com>
 <1415751263-1830-6-git-send-email-tthayer@opensource.altera.com>
 <546BB27A.20405@opensource.altera.com>
Message-ID: <547CD3ED.1080804@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 11/18/2014 02:56 PM, Thor Thayer wrote:
> Hi all,
>
> On 11/11/2014 06:14 PM, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer<tthayer@opensource.altera.com>
>>
>> Adding the device tree entries and bindings needed to support
>> the Altera L2 cache and On-Chip RAM EDAC. This patch relies upon
>> an earlier patch to declare and setup On-chip RAM properly.
>> http://www.spinics.net/lists/devicetree/msg51117.html
>
> Any comments on these devicetree additions?
>
> Thanks,
> Thor
>> Signed-off-by: Thor Thayer<tthayer@opensource.altera.com>
>> ---
>> v2: Remove OCRAM declaration and reference prior patch.
>>
>> v3-5: No Change
>> ---

I originally submitted this series on November 11, 2014.

I haven't received any comments or ACKs on the device tree patch portion 
(patch 5 of 5). According to 
Documentation/devicetree/bindings/submitting-patches.txt, if the patch 
hasn't been Acked after a couple of weeks, the maintainer can pull the 
changes if they are comfortable with those changes.

Dinh checked for merge conflicts in the DTS files in his November 7 
email (queued patches for 3.19).

Dinh acked patches 1 & 2 on November 12.

Thanks,

Thor
