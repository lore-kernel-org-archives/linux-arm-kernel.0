From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 20:53:15 +0100
Subject: [RFC v3 04/13] ahci-platform: Undo pdata->resume on resume failure
In-Reply-To: <20140119194226.GE32165@mtj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-5-git-send-email-hdegoede@redhat.com>
 <20140119112737.GC11123@htj.dyndns.org> <52DC1C15.1030107@redhat.com>
 <20140119191349.GA32165@mtj.dyndns.org> <52DC28DB.7070804@redhat.com>
 <20140119194226.GE32165@mtj.dyndns.org>
Message-ID: <52DC2D2B.3060709@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 08:42 PM, Tejun Heo wrote:
> On Sun, Jan 19, 2014 at 08:34:51PM +0100, Hans de Goede wrote:
>> Well the current error handling still re-disables the clks on resume failure,
>> if you want to proceed with resume as far as possible, rather then return to
>
> Let's put it as "put it in a state where it can be reinitialized
> afterwards".

Ok, I'll drop the patch then.

Regards,

Hans
