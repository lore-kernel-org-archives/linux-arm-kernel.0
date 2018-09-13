From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 13 Sep 2018 09:04:45 +0200
Subject: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
In-Reply-To: <CAOi56cVESykxXg4zcdLh89Rpyiyg587XCkvFG55FnMSro4vH2w@mail.gmail.com>
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
 <7hh8iuxd1y.fsf@baylibre.com>
 <CAOi56cVESykxXg4zcdLh89Rpyiyg587XCkvFG55FnMSro4vH2w@mail.gmail.com>
Message-ID: <fa3fd18a-88a0-7dbf-c5dd-441cfad5459a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 13/09/2018 06:20, Kevin Hilman wrote:
> On Wed, Sep 12, 2018 at 8:59 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>>> The order between "syscon" and "simple-mfd" is important because in these
>>> particular cases, the node needs to be first a "simple-mfd" to expose
>>> it's sub-nodes, and later on a "syscon" to permit other nodes to access
>>> this register space through the "syscon" mechanism.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Applied to v4.20/dt64,
>>
> 
> I spoke too soon, this doesn't apply cleanly on top of Jeromes
> reorder/cleanup.  Please respin/resend.

I'll respin.

Neil

> 
> Kevin
> 
