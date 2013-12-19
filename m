From: a.zummo@towertech.it (Alessandro Zummo)
Date: Thu, 19 Dec 2013 17:38:57 +0100
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <87siton6ke.fsf@natisbad.org>
References: <87siton6ke.fsf@natisbad.org>
Message-ID: <20131219173857.0a546b99@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Dec 2013 17:34:09 +0100
arno at natisbad.org (Arnaud Ebalard) wrote:

> I never heard of *listed* RTC maintainer during all the review process
> on rtc-linux list (v0 sent in october); I dug the list archives and when
> this previously happened, someone else (e.g. Andrew Morton) was kind
> enough to handle the patches:

 Yes, Andrew usually pick those. I do not maintain a separate tree
 due to most RTCs being specifit to a subsytem.

> 
>   http://www.spinics.net/lists/arm-kernel/msg292187.html

 Regarding your patch, please do not add entries to /proc.
 Use sysfs if you need.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
