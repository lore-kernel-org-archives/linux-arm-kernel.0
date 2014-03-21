From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Mar 2014 10:40:00 -0400
Subject: [PATCH] arm: boot: dts: build keystone devicetree blob
In-Reply-To: <53208CDD.7030106@ti.com>
References: <1394639330-1288-1-git-send-email-balbi@ti.com>
 <53208CDD.7030106@ti.com>
Message-ID: <532C4F40.5010903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 March 2014 12:35 PM, Santosh Shilimkar wrote:
> On Wednesday 12 March 2014 11:48 PM, Felipe Balbi wrote:
>> Currently, even when building keystone only
>> kernel builds, DTB won't get build because
>> we lack a Makefile rule to get it compiled.
>>
>> This patch adds that rule so mainline kernel
>> users have a chance to use up-to-date DTB on
>> keystone 2 platforms.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>
> We have been building dtbs with explicit command
> instead of dtbs since it was just one dtb so far
> supported. Was planning to add the rule once more
> boards get added. Now with Lamarr and Edision in
> for next merge window, will do that post 3.15-rc1.
> 
Just to close the loop, I added a patch as part
of my 3.15 fixes which builds all keystone dt
blobs.

Regards,
Santosh
