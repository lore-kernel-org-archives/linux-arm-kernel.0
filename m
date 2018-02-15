From: klimov.linux@gmail.com (Alexey Klimov)
Date: Thu, 15 Feb 2018 00:09:49 +0000
Subject: [PATCH v5 00/20][RESEND] firmware: ARM System Control and
 Management Interface(SCMI) support
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CALW4P+LPiYSOCKW4iS6OwK9S=M3aCP+X6QNnDkycY5TYQsCb5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 6:45 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi all,
>
> ARM System Control and Management Interface(SCMI) is more flexible and
> easily extensible than any of the existing interfaces. Many vendors were
> involved in the making of this formal specification and is now published[1].
>
> There is a strong trend in the industry to provide micro-controllers in
> systems to abstract various power, or other system management tasks.
> These controllers usually have similar interfaces, both in terms of the
> functions that are provided by them, and in terms of how requests are
> communicated to them.
>
> This specification is to standardise and avoid (any further)
> fragmentation in the design of such interface by various vendors.
>
> This patch set is intended to get feedback on the design and structure
> of the code. This is not complete and not fully tested due to
> non-availability of firmware with full feature set at this time.

If it's not fully tested and not complete (I read as this patch set is
not ready to be merged), then maybe it's better to mark it as RFC?


> It currently doesn't support notification, asynchronous/delayed response,
> perf/power statistics region and sensor register region to name a few.
> I have borrowed some of the ideas of message allocation/management from
> TI SCI.
>
> Changes:
>
> v4[6]->v5:
>         - Rebased to v4.16-rc1
>         - Updated all the gathered Ack/Reviewed-by tags(which includes
>           all the drivers using SCMI protocol)

You still didn't comment on all questions to previous patchset.

For example,
https://www.spinics.net/lists/arm-kernel/msg626719.html


Best regards,
Alexey
