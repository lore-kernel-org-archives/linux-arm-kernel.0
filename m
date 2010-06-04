From: lizf@cn.fujitsu.com (Li Zefan)
Date: Fri, 04 Jun 2010 08:57:35 +0800
Subject: [PATCH 2/2] menuconfig: truncate list items
In-Reply-To: <4C07D932.4040404@oracle.com>
References: <4C0758B7.5070907@cn.fujitsu.com>
	<4C0758C9.7080108@cn.fujitsu.com> <4C07D932.4040404@oracle.com>
Message-ID: <4C084F7F.9060802@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Randy Dunlap wrote:
> On 06/03/10 00:24, Li Zefan wrote:
>> Truncate list items to fit in a single line, otherwise those items
>> which have long prompts will cover some other items.
>>
>> This follows the behavior of menubox.
>>
>> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
> 
> Thanks :)
> 
> Tested-by: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Ben, the Samsung S3C24* prompt still gets truncated with this patch (when using
> an 80-column wide xterm).  If you care about seeing all of the models,
> you might want to shorten the prompt.
> 

An alterative is to print the truncated string and end it with "...":

( ) Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440...
