From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 7 Aug 2017 09:04:19 +0000
Subject: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <MWHPR12MB160086C4B4FA8F3B2EC1D5F9C8B60@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home>
 <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <75213fca-4522-2297-3cb8-338e643d3552@huawei.com>
 <CAKgT0UcqdRCwDDxD=22Q_jLuqz8KVHwH1-V45Aq-1WzQw=agcA@mail.gmail.com>
 <14218972-553d-eb60-0207-460ac7f4b064@huawei.com>
 <MWHPR12MB1600A6986E4AD13D302F2DC9C8B00@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20170803083153.GB4883@otc-nc-03>
 <MWHPR12MB1600400EC7DEE92E4A3ADC5BC8B60@MWHPR12MB1600.namprd12.prod.outlook.com>,
 <20170804202141.GA39054@otc-nc-03>
 <MWHPR12MB160086C4B4FA8F3B2EC1D5F9C8B60@MWHPR12MB1600.namprd12.prod.outlook.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD004C785@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Casey Leedom
> Sent: 04 August 2017 21:49
...
> Whenever our Hardware Designers implement new functionality in our hardware,
> they almost always put in A. several "knobs" which can control fundamental
> parameters of the new Hardware Feature, and B.  a mechanism of completely
> disabling it if necessary.  This stems from the incredibly long Design ->
> Deployment cyle for Hardware (as opposed to the edit->compile->run cycle for s!

Indeed, I'd also expect there to be an undocumented flag to turn
it on (broken) in earlier parts to allow testing.

	David
