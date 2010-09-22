From: justinmattock@gmail.com (Justin P. Mattock)
Date: Tue, 21 Sep 2010 20:57:08 -0700
Subject: [PATCH 1/2 v3]Update broken web addresses.
In-Reply-To: <alpine.LNX.2.00.1009221310500.4570@nippy.intranet>
References: <1285118957-24965-1-git-send-email-justinmattock@gmail.com>
	<alpine.LNX.2.00.1009221310500.4570@nippy.intranet>
Message-ID: <4C997E94.8070407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2010 08:25 PM, Finn Thain wrote:
>
> On Tue, 21 Sep 2010, Justin P. Mattock wrote:
>
>> Below is an update from the original, with changes to the broken web
>> addresses and removal of archive.org and moved to a seperate patch for
>> you guys to decide if you want to use this and/or just leave the old url
>> in and leave it at that..
>> Please dont apply this to anything just comments and fixes for now,
>
> You can use [RFC] in the Subject line instead of [PATCH] to indicate this.
>

alright..

>
>> diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
>> index 8f06408..234d9ee 100644
>> --- a/arch/m68k/mac/macboing.c
>> +++ b/arch/m68k/mac/macboing.c
>> @@ -114,7 +114,8 @@ static void mac_init_asc( void )
>>   			 *   16-bit I/O functionality.  The PowerBook 500 series computers
>>   			 *   support 16-bit stereo output, but only mono input."
>>   			 *
>> -			 *   http://til.info.apple.com/techinfo.nsf/artnum/n16405
>> +			 *   Article number 16405:
>> +			 *   http://support.apple.com/kb/TA32601
>>   			 *
>>   			 * --David Kilzer
>>   			 */
>
> "TIL article number 16405" would allow people to find the document by
> number...
>

so putting this "TIL article number 16405" is correct instead of Article 
number 16405:

>
>> diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
>> index 6bdbf48..92806c0 100644
>> --- a/arch/m68k/q40/README
>> +++ b/arch/m68k/q40/README
>> @@ -3,7 +3,7 @@ Linux for the Q40
>>
>>   You may try http://www.geocities.com/SiliconValley/Bay/2602/ for
>>   some up to date information. Booter and other tools will be also
>> -available from this place or ftp.uni-erlangen.de/linux/680x0/q40/
>> +available from this place or http://www.linux-m68k.org/mail.html
>>   and mirrors.
>>
>>   Hints to documentation usually refer to the linux source tree in
>
> No. We already discussed this change. Please refer back to my review of
> the first version of the patch. You got it right in the second version
> (that I also reviewed), but now you've gone back to the first version...
>
> Finn
>

pretty bad.. I don't know what happened there..


Justin P. Mattock
