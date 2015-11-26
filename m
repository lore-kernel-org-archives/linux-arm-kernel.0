From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 26 Nov 2015 11:05:13 +0200
Subject: [PATCH] remoteproc: report error if resource table doesn't exist
In-Reply-To: <1440810499-24327-1-git-send-email-stefan@agner.ch>
References: <1440810499-24327-1-git-send-email-stefan@agner.ch>
Message-ID: <CAK=WgbYLDTNjbq=Qn7wFqN44PTM7yqAVjDZycEq4Eri5C5unGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sat, Aug 29, 2015 at 4:08 AM, Stefan Agner <stefan@agner.ch> wrote:
> Currently, if the resource table is completely missing in the
> firmware, powering up the remoteproc fails silently. Add a message
> indicating that the resource table is missing in the firmware.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied to remoteproc-next, thanks.

> This also opens up a more general question: Is it mandatory to have
> a resource table in the firmware?

The implementation we have today does require it, but that's just
because this is what we had to support so far.

> Theoretically a remoteproc could
> also work completely independent, all what would be used from the
> remoteproc framework is the loading and starting capabilities...

Sure. Feel free to add support for your hardware as needed.

Thanks,
Ohad.
