From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 2 Feb 2016 10:44:00 +0530
Subject: [PATCH v4 1/3] mailbox: Add support for APM X-Gene platform
 mailbox driver
In-Reply-To: <CADaLNDmSiK27wYBSo8-DsafmG5jUumUR5WYgConeSFXGNjH6+w@mail.gmail.com>
References: <CABb+yY2zHycEmsVvp8OFwpJ1PZgrEPpV-oOe56wgFJ=EE0nTcg@mail.gmail.com>
 <cover.1452912126.git.dhdang@apm.com>
 <abff73c051fd06a9dd3b04a1e7957ad5a9b69a18.1452912126.git.dhdang@apm.com>
 <CADaLNDmSiK27wYBSo8-DsafmG5jUumUR5WYgConeSFXGNjH6+w@mail.gmail.com>
Message-ID: <CABb+yY1cE152ZdfK_aeB8ufG=WfoUVB6BN8kXPphYgMBnpH-GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 1:08 AM, Duc Dang <dhdang@apm.com> wrote:
> Hi Jassi,
>
> On Fri, Jan 15, 2016 at 6:57 PM, Duc Dang <dhdang@apm.com> wrote:
>> X-Gene mailbox controller provides 8 mailbox channels, with
>> each channel has a dedicated interrupt line.
>
> Did you have a chance to look into this version 4 of my mail-box patch?
>
Seems ok, please just fix the "section mismatch" warnings reported by
the build-bot.

Thanks
