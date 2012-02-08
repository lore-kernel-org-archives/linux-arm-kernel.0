From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 8 Feb 2012 23:01:19 +0200
Subject: [PATCH 1/2] remoteproc: bail out if firmware has different
 endianess
In-Reply-To: <20120131200945.GD22611@ponder.secretlab.ca>
References: <1328028762-28352-1-git-send-email-ohad@wizery.com>
 <20120131200945.GD22611@ponder.secretlab.ca>
Message-ID: <CAK=WgbaHE4poc7jxhqc9EEYtbpRqDoC87jMGpS6=OJNZJfe9Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 10:09 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Tue, Jan 31, 2012 at 06:52:41PM +0200, Ohad Ben-Cohen wrote:
>> At this point we don't support remote processors that have
>> a different endianess than the host.
>>
>> Look out for these unsupported scenarios, and bail out if
>> encountered.
>>
>> Reported-by: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Cc: Mark Grosen <mgrosen@ti.com>
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks, applied both patches to remoteproc's for-next.
