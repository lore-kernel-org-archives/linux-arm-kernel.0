From: hdegoede@redhat.com (Hans de Goede)
Date: Thu,  1 Sep 2016 21:08:19 +0200
Subject: [RFC 0/1] misc: Add Allwinner Q8 tablet hardware manager
Message-ID: <20160901190820.21987-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a first RFC for the q8 tablet hw-manager I've been talking
about for a while now.

The touchscreen part is finished, I'll start working on the
accelerometer bits next.

Note that this requires the "of: changesets: Introduce changeset
helper methods" patch from Pantelis. If that is still not upstream
when I'm ready to post a non RFC, I'll post a new version of that
myself.

Regards,

Hans
