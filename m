From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 12 Sep 2017 19:41:28 +0200
Subject: [media] s5p-mfc: Adjust a null pointer check in four functions
In-Reply-To: <5b8eb902-d97c-3308-5ba9-64469320e0e2@users.sourceforge.net>
References: <482a6c92-a85e-0bcd-edf7-3c2f63ea74c5@users.sourceforge.net>
 <e794361b-8f2a-7457-007f-72ef4fa66d02@users.sourceforge.net>
 <CGME20170911092134epcas2p1a1b11c056b52d68c3b0e4ea2e1e8f758@epcas2p1.samsung.com>
 <6c2d20b3-4437-0473-73d4-73c049ba52a9@samsung.com>
 <a68020cc-2477-5d6c-bc61-d753253b755a@users.sourceforge.net>
 <0fa9a180-be67-3a33-682c-bff819c36c6a@samsung.com>
 <5b8eb902-d97c-3308-5ba9-64469320e0e2@users.sourceforge.net>
Message-ID: <ee8ba7fd-1de4-b1b9-8aa0-130c86c38f30@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2017 05:00 PM, SF Markus Elfring wrote:
>>> * Do you care to preserve an information like the author date?
>> In this case not, but actually the Date line is not an issue.
> Thanks for your information.
> 
> It seems then that you quoted a line too much.
>  
>> Anyway the patch is malformed, ?
 >
> I have got doubts for this view because the file was automatically generated
> by the command ?git format-patch? also for the discussed three update steps.

Generating patch is only part of the story, it seems the patch is not sent
properly and tags which should be in SMTP header end up in the message
body. I think there would not be such issues if you have used git format-patch
+ git send-email.

I normally do amend things like this while applying, I will do that this time 
as well. It's already too much time wasted for such a dubious patch.

-- 
Thanks,
Sylwester
