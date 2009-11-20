From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 20 Nov 2009 12:04:15 +0100
Subject: [PATCH 1/1] mx31moboard: change initial reset status for robot
	microcontollers
In-Reply-To: <4B06748A.6050709@ru.mvista.com>
References: <1258640121-12637-1-git-send-email-valentin.longchamp@epfl.ch>
	<1258711647-25993-1-git-send-email-valentin.longchamp@epfl.ch>
	<4B06748A.6050709@ru.mvista.com>
Message-ID: <4B0677AF.5020008@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> Hello.
> 
> Valentin Longchamp wrote:
> 
>> We want the microcontrollers to be held in reset during kernel boot.
>>
>> I just removed a typo in the changelog and commit message, thanks Uwe.
>>
>> This patch is trivial and should go into next -rc.
>>   
> 
>    You should put such comments under --- tearline, so that that will be 
> automatically dropped when applying the patch.
> 

Thanks for the comment, now I have found out that I can do it with the 
--anotate option of git-send-email. Resend comming now.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
