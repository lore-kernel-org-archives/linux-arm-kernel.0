From: rafael@kernel.org (Rafael J. Wysocki)
Date: Mon, 25 Jun 2018 10:06:04 +0200
Subject: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
In-Reply-To: <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180611053826.GC16091@dragon>
 <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
Message-ID: <CAJZ5v0j9P6dXM+8qBdgGwfd8diQ4F+hh+QZ8h09y769YYFtEkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 10:01 AM, S?bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> Hi,
>
> On 06/11/2018 07:38 AM, Shawn Guo wrote:
>> On Tue, May 22, 2018 at 08:28:51AM +0200, S?bastien Szymanski wrote:
>>> Check the max speed supported from the fuses for i.MX6ULL and update the
>>> operating points table accordingly.
>>>
>>> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
>>
>> Acked-by: Shawn Guo <shawnguo@kernel.org>
>>
>
> Thanks, but what about the two others patches ? Now that patch 1 is in
> 4.18-rc1, should I resend the two others patches ?

Please do.

> Should I merge them together ?

If they make related changes, you can do that.
