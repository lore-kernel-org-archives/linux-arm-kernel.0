From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 8 Apr 2016 13:34:26 -0700
Subject: [PATCH] net: thunderx: Fix broken of_node_put() code.
In-Reply-To: <20160408.161557.850174112269792582.davem@davemloft.net>
References: <1459472517-5696-1-git-send-email-ddaney.cavm@gmail.com>
 <5707DF3F.3000508@caviumnetworks.com>
 <20160408.161557.850174112269792582.davem@davemloft.net>
Message-ID: <570815D2.5050608@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2016 01:15 PM, David Miller wrote:
> From: David Daney <ddaney@caviumnetworks.com>
> Date: Fri, 8 Apr 2016 09:41:35 -0700
>
>> Due to mail server malfunction, this patch was sent twice.  Please
>> ignore this duplicate.
>
> This submission had another problem too.
>
> Do not use the date of your commit as the date that gets put into
> your email headers.

I don't.  This is standard git-send-email 1.7.11.7.


>
> This makes all of your patch submissions look like they occurred in
> the past, and this mixes up the ordering of patches in patchwork.


They did occur in the past.  Just like all e-mail you read, they were 
sent before you read them.

I ran git-send-email for this on  Thu, 31 Mar 2016 18:01:57 -0700.  I 
observed that the patch didn't seem to make it to the public lists, so I 
figured I screwed something up and I sent it again, with the same results.

Then I went on vacation, and came back today to sort everything out.  My 
MTA had died, so I restarted it, and ... the backlog of messages was 
sent and you read it.


>
> So please resubmit this properly with a normal, current, date in your
> email headers.

OK, I will resend the identical patch for the third time...
